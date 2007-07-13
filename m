From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: Re: 40-wire/80-wire detection
Date: Fri, 13 Jul 2007 08:04:35 -0400
Message-ID: <46976A53.7060503@seclark.us>
References: <527770.57572.qm@web58107.mail.re3.yahoo.com> <46969D09.4010607@garzik.org>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpauth03.prod.mesa1.secureserver.net ([64.202.165.183]:48290
	"HELO smtpauth03.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755293AbXGMMLQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 08:11:16 -0400
In-Reply-To: <46969D09.4010607@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Craig Block <chblock3@yahoo.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:

>Craig Block wrote:
>  
>
>>Linux kernel: version 2.6.22.1
>>Chipset: VIA VT8363 + VT82C686A
>>Hard drives: Quantum Fireball LCT10 (UDMA66)
>>
>>I'm having a problem with the 80-wire/40-wire cable detection in the
>>ata driver.  Even when I configure the kernel with IDEDMA_IVB set, I
>>still get the 40-wire speed downgrade on hda.
>>
>>Why did you guys put that 80-wire/40-wire cable detection in the ata
>>driver anyway?  Since when is it your job to police me in making sure
>>I'm using the correct cable on my drives.  
>>    
>>
>
>If you signal a 40-wire cable too fast, you get trouble with a capital T.
>
>	Jeff
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>
This would be fine if the software could correctly figure it out. 
Problem is it can't always
get it right so the user should be allowed to "override" it at their own 
risk.  Linux is turning
into winblows  - in that  choice is be taken away from the user.

My $.02
Steve Clark

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



