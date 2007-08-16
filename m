From: vandrove@vc.cvut.cz
Subject: RE: sata_sil, sil3512, and PMP?
Date: Thu, 16 Aug 2007 03:55:41 +0200
Message-ID: <1187229341.46c3ae9d6f1ff@imap.vc.cvut.cz>
References: <E8F452C423BB2E439AA9E397EB8A95F3038D9875@telegraph.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.vc.cvut.cz ([147.32.240.222]:52232 "EHLO imap.vc.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755593AbXHPCjX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 22:39:23 -0400
In-Reply-To: <E8F452C423BB2E439AA9E397EB8A95F3038D9875@telegraph.siliconimage.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eunice Chen <Eunice.Chen@siliconimage.com>
Cc: Petr Vandrovec <petr@vandrovec.name>, linux-ide@vger.kernel.org

Quoting Eunice Chen <Eunice.Chen@siliconimage.com>:

> 3512/3112/3114 controllers do not support PMP. 3124/3132 controllers do.

Um...  Well, that's bad.  Can you update datasheet then?  

http://www.siliconimage.com/docs/SiI-DS-0102-D.pdf says on page 77:

===
Serial ATA SControl
Address Offset: 0x100 (Channel 0) / 0x180 (Channel 1)
Access Type: Read/Write
Reset Value: 0x0000_0010
...
This register is the SControl register as defined by the Serial ATA specification.
&#8226; Bit [19:16]: PMP - This field is the 4-bit value to be placed in the Port
Multiplier Port field of all transmitted FISes.
===
and there is also pm_fiscfg bitfield in SMisc :-(

Provoking false hopes from unsuspecting readers :-(  I'll shell out some money
then...
                                     Thanks,
                                             Petr

> Eunice
> 
> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org
> [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Petr Vandrovec
> Sent: Wednesday, August 15, 2007 5:47 AM
> To: linux-ide@vger.kernel.org
> Subject: sata_sil, sil3512, and PMP?
> 
> Hello,
>    is anybody working on PMP support in sata_sil driver, or should I 
> give it a try, or is it simpler to just shell out $70 to get 3124 based 
> device with FIS based switching?
> 
> According to datasheet it seems that 3512 should be able to do command 
> based switching without (too big) problems.  Though I'm not very 
> confident as whole PMP support fits into two sentences in 3512 public 
> datasheet :-(
> 					Thanks,
> 						Petr Vandrovec
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 



