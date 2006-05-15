From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 08:36:46 +0900
Message-ID: <4469108E.1030502@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:58260 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750784AbWEOXgv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 19:36:51 -0400
Received: by py-out-1112.google.com with SMTP id x31so1501791pye
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 16:36:51 -0700 (PDT)
In-Reply-To: <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Avuton Olrich <avuton@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

Avuton Olrich wrote:
> On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
>> * sata_sil and ata_piix also need healthy re-testing of all basic
>> functionality.
> 
> I'm testing it right now, but with 2.6.17-rc4-git2 I was getting:
> 
> May 15 15:42:57 shapeshifter ata2: command 0x25 timeout, stat 0x58 
> host_stat 0x1
> May 15 15:42:57 shapeshifter ata2: translated ATA stat/err 0x58/00 to
> SCSI SK/ASC/ASCQ 0xb/47/00
> May 15 15:42:57 shapeshifter ata2: status=0x58 { DriveReady
> SeekComplete DataRequest }
> May 15 15:42:57 shapeshifter sd 1:0:0:0: SCSI error: return code = 
> 0x8000002
> May 15 15:42:57 shapeshifter sda: Current: sense key=0xb
> May 15 15:42:57 shapeshifter ASC=0x47 ASCQ=0x0
> May 15 15:42:57 shapeshifter end_request: I/O error, dev sda, sector 
> 974708575

2.6.17-rc4-git2 doesn't contain the changes.  You're still using old EH. 
  To test the updates, pull #upstream from libata-dev git tree which can 
be found on http://kernel.org/git.  Otherwise, you can try 
libata-tj-stable patch over 2.6.16.16 located at

http://home-tj.org/wiki/index.php/Libata-tj-stable.

-- 
tejun
