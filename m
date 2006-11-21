From: Tejun Heo <htejun@gmail.com>
Subject: Re: CDROM drive not found when booting using new libata code
Date: Tue, 21 Nov 2006 18:26:52 +0900
Message-ID: <4562C65C.2010802@gmail.com>
References: <20060924221020.GB2080@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:10609 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S966943AbWKUJ1F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 04:27:05 -0500
Received: by nf-out-0910.google.com with SMTP id o25so124727nfa
        for <linux-ide@vger.kernel.org>; Tue, 21 Nov 2006 01:27:04 -0800 (PST)
In-Reply-To: <20060924221020.GB2080@artsapartment.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Art Haas wrote:
> Hi.
> 
> As Linus has just pulled in the large libata changes into his tree, I
> wanted to try out the new code. I'm running Debian on a PIIX
> motherboard, and I've enclosed the 'dmesg' output for the machine
> when booting 2.6.18 which uses the piix.c code in drivers/ide and
> the new 2.6.18+ code which uses ata_piix.c in drivers/ata.

Can you please test 2.6.19-rc5-mm2?

-- 
tejun
