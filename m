From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Believed resolved: SATA kern-buffRd read slow: based on promise
 driver bug
Date: Thu, 03 Jan 2008 20:49:15 -0600
Message-ID: <477D9EAB.7090202@shaw.ca>
References: <fa.6TIOCGhBpW0r4XW9rqR+Ad8P+Js@ifi.uio.no>
 <4777E08C.4000603@shaw.ca> <4779870E.5070507@tlinx.org>
 <20080101015812.59e9ebf0@the-village.bc.nu> <477BEF8D.8090307@tlinx.org>
 <477C2B71.7040504@shaw.ca> <477C63AA.8080006@tlinx.org>
 <18300.40661.199761.488061@harpo.it.uu.se> <477D9C00.8060600@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758253AbYADCuW@vger.kernel.org>
In-reply-to: <477D9C00.8060600@tlinx.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linda Walsh <lkml@tlinx.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Linda Walsh wrote:
>    I seem to remember reading about some problems with Promise SATA & ACPI.
> Does this address that or is that a separate issue?  (Am using no-acpi for
> now, but would like to try acpi again if it may be fixed (last time I tried
> it with this card, "sdb" went "offline" (once it unmounted itself and
> refused to be remounted (no error...just nothing), and another it stayed
> mounted, but gave an I/O Error...so have been using no-acpi since).
> An ACPI error in bootup said:
> ACPI Exception (utmutex-0263): AE_BAD_PARAMETER, Thread EFFC2000 could 
> not acquire Mutex [3] [20070126]

Have you tried 2.6.24-rc6? If the problem still occurs there, you should 
post the full bootup log.

> 
>    Is the above bug mentioned/discussed in the linux-ide archives?  That
> and I'd like to find out why TCQ/NCQ doesn't work with the Seagate 
> drives --
> my guess, since they say queuedepth of 0/32, is that they are blacklisted
> as being drives that don't follow normal protocol or implement their
> own proprietary extensions?  Sigh.  Really a lame move (if that's the case)
> for Seagate, considering they usage they could likely get in server
> configs.  Maybe they want to push their SCSI/SAS drives?

Queue depth 0/32 means the drive supports a queue depth of 32 but the 
controller/driver don't support NCQ.

>    BTW, can SATA have DPO or FUA or are those limited to SCSI?
> Would it be a desirable future addition to remove the
> "doesn't support DPO or FUA" error message" on SATA drives if they are
> specific to SCSI?

ATA disks can have FUA support, but the support is disabled in libata by 
default. (There's a fua parameter on libata module to enable it I believe.)
