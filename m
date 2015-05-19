From: Kevin Groeneveld <KGroeneveld@lenbrook.com>
Subject: RE: imx6 sata cdrom driver issue
Date: Tue, 19 May 2015 15:18:37 -0400
Message-ID: <E4B483B64FC69D4292AD9E0D554A23A4098E96D6@FLINT.pickering.lenbrook.com>
References: <5539101D.1020909@lenbrook.com> <15678294.L2fz4hMtva@wuerfel>
 <555B8B6D.2070500@lenbrook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Class: urn:content-classes:message
In-Reply-To: <555B8B6D.2070500@lenbrook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Bagg <JBagg@lenbrook.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

-----Original Message-----
From: Jonathan Bagg 
Sent: May-19-15 3:14 PM

>Adding my co-worker Kevin who has done a few experiments in the kernel

I am one of Jonathan's co-workers who has been helping to diagnose and
fix the SATA issue we are experiencing.  Most of my testing has been
with an optical drive connected directly to the Freescale Sabre board.

Using the debug patch I wrote that Jon posted earlier I can see that the
response to the ATAPI 0x4A command (Get Event Status Notification)
during initial boot is always random. For example:

[    2.237783] CDB rbuf: [4a 01 00 00 10 00 00 00 08]
[    2.237789] CDB rbuf: 00000000: 7e 31 f7 fd ff f5 7d fd
~1....}.

Running the same test on an iMX53 EVK board the response is always:

[    2.452303] CDB rbuf: [4a 01 00 00 10 00 00 00 08]
[    2.452308] CDB rbuf: 00000000: 00 06 04 56 02 02 00 00
...V....

We have rented a Lecroy STX-231 SATA protocol analyzer. Using this tool
I have verified that the response from the optical drive is always
correct in this case but for some reason the data is corrupt by the time
the debug code I added to atapi_qc_complete dumps the response.

I have added debug code to dump the AHCI command header and table before
issuing a command. I have not seen anything out of the ordinary here. I
also added debug code to dump the received FIS on an interrupt. I
haven't studied the received FIS extensively but I did not see anything
out of the ordinary here either.

One thing I suspected and confirmed with the Lecroy analyzer is that the
response to the previous command during boot (ATAPI command 0x5A - Mode
Sense) is always 64 bytes even though the kernel is requesting 128
bytes. This exact behaviour is probably drive dependant.  On a hunch I
modified the get_capabilities function in drivers/scsi/sr.c to only
request 64 bytes. With that change the response to the Get Event Status
Notification command during boot is always valid.  Although running
cdparanoia or trying to keep using the system in other ways still
results in issues.

Using the Lecroy analyzer I found some other commands where cdparanoia
requests lengths longer than the drive responds with.  Comparing the
debug dumps in the kernel to the data captured by the analyzer I can see
problems always start after this happens.

To try and characterize this further I started messing around with the
request lengths.  I noticed in the AHCI command header dumps I added
that many of the ATAPI commands have a second SG DMA buffer. I found the
second buffer is added when atapi_drain_needed returns true in
libata-scsi.c.  I started hacking the DMA buffer sizes by manipulating
the lengths written to the AHCI command table in the ahci_fill_sg
function in libata.c.  I also hacked atap_drain_needed to sometimes
return false to force only one DMA buffer for ATAPI commands.

What I found is that if there are two DMA buffers and the response
length is less than the first buffer size then the response to the next
command is always corrupted.  Every other scenario I tried worked okay.
Filling the first buffer and under, over or exactly using the second
buffer does not trigger the issue.  If there is only one buffer under,
over or exactly using the one buffer does not trigger the issue.

One other thing I noticed is that if the response under runs the first
buffer and the second ATAPI drain buffer is smaller than the next
command response then the response to the next command is missing the
begging of the response equal to the length of the second buffer from
the previous command. I decided to add some debug code to print out the
DMA buffer used for the previous command. What I found is that the
missing part of the response is written to the DMA buffer from the
previous command.  This is very bad as that memory could be dynamically
allocated and subsequently freed and now in use by something else!

Since overruns never seem to cause an issue in this setup I decided to
simply change the atap_drain_needed function to always return false.
With this change I can run cdparanoia successfully and rip audio tracks.
I can also add a port multiplier back to the setup and connect both an
HDD and the optical drive and experience no readily apparent issues.

So it seems I have found a workaround for the most severe symptoms we
were experiencing. But this still leaves me with several questions and
concerns:

1. Is the root cause some obscure bug in the kernel I have not found
yet? Or is it a hardware bug in the iMX6 AHCI SATA host? Or maybe
something else silly we have been doing?

2. When cdparanoia is ripping the actual data it uses large reads which
use multiple SG DMA buffers. What happens if the response is short in
this case? My atapi_drain_needed hack won't help in this case.
cdparanoia could probably be modified to only do smaller reads that fit
in one page to avoid the issue.

3. Can the issue happen with non ATAPI commands?  If for any reason an
ATA command to a HDD has a short response could all future commands (and
possibly even system memory) be corrupted similar to what I saw with
ATAPI commands? I wonder if the kernel could be easily modified to limit
the size of ATA commands to avoid this scenario.

4. The Lecroy analyzer can also emulate a device. Using this mode I
tried to trigger the issue with ATA commands. I couldn't figure out how
to trigger the exact scenario I wanted.  I was able to cause the
response to be too short, just not short enough to underrun anything but
the last DMA buffer which doesn't seem to cause a problem.  What I did
notice though was that this didn't seem to trigger an error anywhere in
the kernel or user space, the data would just simply be corrupted. I
would expect the system should flag the response as being invalid and an
IO error propagated all the way to user space.
