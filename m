From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: sata_via - too slow
Date: Sat, 07 Aug 2004 01:24:07 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41148397.400@clanhk.org>
References: <410E2E9C.8020606@scssoft.com> <410EC673.1090506@clanhk.org> <410EBE89.9000008@scssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.hardcore-gaming.net ([69.93.101.157]:19117 "EHLO
	mail.hardcore-gaming.net") by vger.kernel.org with ESMTP
	id S266289AbUHGGYM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Aug 2004 02:24:12 -0400
In-Reply-To: <410EBE89.9000008@scssoft.com>
List-Id: linux-ide@vger.kernel.org
To: Petr Sebor <petr@scssoft.com>
Cc: linux-ide@vger.kernel.org

Petr Sebor wrote:

>> What motherboard is this?  The MSI FAR2 whatever?
>
>
> It is MSI Master2-FAR.. sorry for not mentioning that.

Really?  Do you have APIC working?  I haven't gotten onboard IDE to work 
without DMA timeouts when APIC is enabled on the KT800 MB I have, but 
it's UP so I can live without it.  The current buglist said it's fixed 
for -some- motherboards.  I would suggest you ask about this on the 
x86_64.org list, you're more likely to find an answer there.

Sorry for the slow reply, had to beat Doom3 before I could move on with 
my life.

-ryan
