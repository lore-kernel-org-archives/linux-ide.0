From: "Avuton Olrich" <avuton@gmail.com>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 16:30:26 -0700
Message-ID: <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:44886 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750768AbWEOXa2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 19:30:28 -0400
Received: by nf-out-0910.google.com with SMTP id o25so172154nfa
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 16:30:26 -0700 (PDT)
In-Reply-To: <20060515170006.GA29555@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
> * sata_sil and ata_piix also need healthy re-testing of all basic
> functionality.

I'm testing it right now, but with 2.6.17-rc4-git2 I was getting:

May 15 15:42:57 shapeshifter ata2: command 0x25 timeout, stat 0x58 host_stat 0x1
May 15 15:42:57 shapeshifter ata2: translated ATA stat/err 0x58/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
May 15 15:42:57 shapeshifter ata2: status=0x58 { DriveReady
SeekComplete DataRequest }
May 15 15:42:57 shapeshifter sd 1:0:0:0: SCSI error: return code = 0x8000002
May 15 15:42:57 shapeshifter sda: Current: sense key=0xb
May 15 15:42:57 shapeshifter ASC=0x47 ASCQ=0x0
May 15 15:42:57 shapeshifter end_request: I/O error, dev sda, sector 974708575

(sector varies)

After large ssh transfers. I moved to 2.6.17-rc4-git2 because
2.6.16.16 was doing the same. This is a new 500gb sata2 drive on
sata_sil so I guess this could be hardware, but I wanted to make sure
before I go returning this thing. After this obviously I have to sysrq
sync, ro and reboot. This also causes(?) a NETDEV WATCHDOG: eth2:
transmit timed out, sometimes this ata timeout doesn't yet occur and I
just get the netdev watchdog. This has not yet happened with the new
patch, though I'm only 1 hr into testing with it.


If you want to take a peek at my config:
http://olricha.homelinux.net:8080/ss.config
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
