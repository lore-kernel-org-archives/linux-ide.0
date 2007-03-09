From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Again problems with PDC20268 and vol_id
Date: Fri, 9 Mar 2007 19:08:56 +0300
Message-ID: <20070309190856.c86efd73.vsu@altlinux.ru>
References: <4964.131.211.80.61.1173446203.squirrel@hammerhead.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0668100555=="
Return-path: <linux-hotplug-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4964.131.211.80.61.1173446203.squirrel@hammerhead.dyndns.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-hotplug-devel>
List-Post: <mailto:linux-hotplug-devel@lists.sourceforge.net>
List-Help: <mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-hotplug-devel-bounces@lists.sourceforge.net
Errors-To: linux-hotplug-devel-bounces@lists.sourceforge.net
To: Guido Diepen <guido@jcwodan.nl>
Cc: linux-ide@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
List-Id: linux-ide@vger.kernel.org

--===============0668100555==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__9_Mar_2007_19_08_56_+0300_S=dbrjqWm_.zKVSX"

--Signature=_Fri__9_Mar_2007_19_08_56_+0300_S=dbrjqWm_.zKVSX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 9 Mar 2007 14:16:43 +0100 (CET) Guido Diepen wrote:

> some time ago I mentioned on this mailing list that I had some problems
> with udev in combination with a promise PCI IDE controler (PDC20268
> chipset). As soon as I had udev enabled, one of the things that was done
> during device creation was a call to the vol_id program. Whenever vol_id
> was executed on one of the drives attached to this extra IDE controller,
> my system would freeze with the following snippet of errors:
>
> hdg: dma_intr: status=0x51 { DriveRead SeekComplete Error}
> hdg: dma_intr: error=0x10 {SectorIdNotFound }, LBAsect= ... (rest of this
> I could not see anymore on the foto I took of the screen)

However, that value is important - together with the kernel messages
printed during detection of drivers.  Most likely the sector number is
out of range for your disk, and the disk replies to such access with
the SectorIdNotFound error.

Just provide the full dmesg output if you are unsure which lines are
relevant for the problem.

> ide: failed opcode was: unknown
>
> This error repeats a couple of times, then I get the message:
> hdg: DMA disabled
> PDC202XX: Secondary channel reset.
> ide3: reset: success
> hdg: task_in_intr: status=0x59 { DriveReady SeekComplete ...
> hdg: task_in_intr: error=0x10 {SectorIdNotFound }, LBAsect ...
>
> This particular harddrive is a 120 GB Maxtor 4G120J6 drive and is split
> into two equal size partitions of 58GB and this error only occurred when
> the vol_id was ran on the second partition (hdg2) and nothing happened
> when running it on the first partition.

Please provide also the "fdisk -l -u /dev/hdg" output.

Is the partition table correct?  Maybe the partition extends beyond
the end of physical disk for some reason, and when the kernel tries to
access last blocks of the partition, it actually tries to read sectors
beyond the actual drive capacity, which fails and exposes broken error
handling in the Promise IDE driver.

I have added the linux-ide mailing list to Cc: - problems related to
IDE/ATA drivers (both old IDE, which you are using currently, and
newer libata) should be discussed there.

> I started looking more into the problem and found out that the vol_id
> program would only crash IF it was looking for raid. If I rain the vol_id
> program with the option --skip-raid, everything worked flawless.

With --skip-raid vol_id does not look for Linux software RAID
superblocks, which are located at the end of device.

--Signature=_Fri__9_Mar_2007_19_08_56_+0300_S=dbrjqWm_.zKVSX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQFF8YabW82GfkQfsqIRAo0nAJ4rPnQXposf2pfU3XZ8t/cGA0mfYQCfQqJw
iL7zQshTBgMveUjWJGGRI0Q=
=4t7d
-----END PGP SIGNATURE-----

--Signature=_Fri__9_Mar_2007_19_08_56_+0300_S=dbrjqWm_.zKVSX--


--===============0668100555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0668100555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-hotplug-devel mailing list  http://linux-hotplug.sourceforge.net
Linux-hotplug-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel

--===============0668100555==--
