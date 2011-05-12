From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: [PATCH] ATA: pata_at91.c bugfixes
Date: Thu, 12 May 2011 16:03:40 +0400
Message-ID: <4DCBCC9C.2040209@gmail.com>
References: <1303299877-12088-1-git-send-email-plyatov@gmail.com> <20110423093623.GA3410@localhost.localdomain> <4DB6684C.7050505@gmail.com> <20110427183819.GA2285@localhost.localdomain> <4DBA9E2F.3070100@gmail.com> <20110501211716.GA5217@localhost.localdomain>
Reply-To: plyatov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63618 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549Ab1ELMDp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 May 2011 08:03:45 -0400
Received: by bwz15 with SMTP id 15so1226657bwz.19
        for <linux-ide@vger.kernel.org>; Thu, 12 May 2011 05:03:43 -0700 (PDT)
In-Reply-To: <20110501211716.GA5217@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org

Hello Stanislaw!

Thank you for patience and detailed explanations!

Sorry for long delays between answers, but I must work with another 
projects.

>
>>>> * The NCS signal is not the same as CS1, CS2 ATA signals! It used only to
>>>>    enable data bus transceiver U2.
>>> Well, they are different signals but connected together. All of these are
>>> controlled by NCS: CFCE1 (CS1), CFCE2 (CS2), CFRNW (DIR), CFCS0 (OE)
>>> if SMC is configured in True IDE mode.
>> I must repeat again - NCS ("CFCS1" from schematic) are completely
>> different signal for different purpose, then A0, A1, A2, CS0, CS1.
>> It used only to enable data bus transceiver U2.
> So, how in your opinion CS0 and CS1 are controlled? IMO there
> are delivered from CFCE1 and CFCE2, which itself are delivered
> from NCS. Here is corresponding quote from atmel documentation
> you cited above:
>
> "The CFCE1 and CFCE2 waveforms are identical to the corresponding NCSx waveform"

This makes picture completely clean for me now.

I will publish new version patch for pata_at91.c.

Best regards!

-- 
Igor Plyatov

