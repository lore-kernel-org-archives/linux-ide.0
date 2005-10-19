From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: hdparm ATA Security Options return errors
Date: Wed, 19 Oct 2005 18:24:47 +0200
Message-ID: <4356734F.6050303@gmx.de>
References: <S1750797AbVJQQjQ/20051017163916Z+71@vger.kernel.org> <4353DBF1.1060001@gmx.de> <4353E257.5060104@gmx.de> <43540A36.2080404@rtr.ca> <4355FC28.2020704@gmx.de> <4356624A.2000307@rtr.ca>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.de ([213.165.64.20]:9434 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751097AbVJSQZI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2005 12:25:08 -0400
In-Reply-To: <4356624A.2000307@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> thomas schorpp wrote:
> 
>> Mark Lord wrote:
>>
>>> I think the entire set of ATA security patches that were
>>> sent to me for hdparm are bogus -- I lack the setup here
>>> to try them, but another kind person is preparing patches
>>> for hdparm to fix them.
> 
> 
> hdparm-6.3 is now out, with working security commands.
> 
> But there is still a bug deep in the IDE taskfile code
> that sometimes causes problems.  Someday I might have time
> to dig deeper into the kernel and fix that issue.
> 
> -ml
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

test01:

vanilla kernel 2.6.13.4

no security enabled before, no passwort.

hdparm --security-disable xxxx /dev/hde

Oct 19 18:15:51 tom1 kernel: hde: status timeout: status=0xd0 { Busy }
Oct 19 18:15:51 tom1 kernel: ide: failed opcode was: 0xf2
Oct 19 18:15:51 tom1 kernel: hde: no DRQ after issuing MULTWRITE_EXT
Oct 19 18:15:51 tom1 kernel: hde: status error: status=0x00 { }
Oct 19 18:15:51 tom1 kernel: ide: failed opcode was: 0xf6
Oct 19 18:15:51 tom1 kernel: hde: no DRQ after issuing MULTWRITE_EXT

sync problem?

ATA device, with non-removable media
        Model Number:       ST3120026A
        Serial Number:      3JT4RYCB
        Firmware Revision:  8.01
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 2
        Supported: 6 5 4 3

sil680 controller

i'll test the SET commands on the older seagate

