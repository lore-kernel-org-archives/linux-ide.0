From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: hdparm ATA Security Options return errors
Date: Mon, 17 Oct 2005 19:41:43 +0200
Message-ID: <4353E257.5060104@gmx.de>
References: <S1750797AbVJQQjQ/20051017163916Z+71@vger.kernel.org> <4353DBF1.1060001@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.net ([213.165.64.20]:64734 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751046AbVJQRmC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Oct 2005 13:42:02 -0400
In-Reply-To: <4353DBF1.1060001@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

thomas schorpp wrote:
> hi,
> 
> hdparm
> 
> ATA Security Options:
>  --security-unlock PWD          Unlock drive, using password PWD (DANGEROUS)
>  --security-set-pass PWD        Lock drive, using password PWD (DANGEROUS)
>  --security-disable PWD         Disable drive locking, using password
> PWD (DANGEROUS)
>  --security-mode MODE           Specify user/master password and
> high/maximum security
> 
> fail by returning errors "cannot allocate mem", "invalid argument", with
> 
> hdparm binary from debian stable...sid / whax /knoppix with kernels
> 2.6.11...2.6.13...latest debian sid image with
> 
> usual via ide + sil680 controllers and
> 
> ATA device, with non-removable media
>         Model Number:       Maxtor 6E040L0
>         Serial Number:      E14FQN5E
>         Firmware Revision:  NAR61590
> Standards:
>         Supported: 7 6 5 4
> 
> ATA device, with non-removable media
>         Model Number:       ST3120026A
>         Serial Number:      3JT4RYCB
>         Firmware Revision:  8.01
> Standards:
>         Used: ATA/ATAPI-6 T13 1410D revision 2
>         Supported: 6 5 4 3
> 
> .
> 
> does it help to compile hdparm from source against the vanilla kernel?
> 
> wheres the latest source? biblio? or is there a cvs?
> 
> meanwhile ill take a look at the debian sid source package's code...
> 
> y
> tom
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

1.

hdparm.c line 101

static char security_password[64];

shouldnt it be 128? passphrase + padding to 128 bytes?




