From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: update Kconfig text to mark as deprecated
Date: Fri, 30 Oct 2009 01:38:00 -0700 (PDT)
Message-ID: <20091030.013800.132652248.davem@davemloft.net>
References: <51f3faa70910291719kecb5edcp3b8812981b69acb1@mail.gmail.com>
	<20091029.173028.248393897.davem@davemloft.net>
	<200910300915.51836.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756320AbZJ3Ihp@vger.kernel.org>
In-Reply-To: <200910300915.51836.Martin@lichtvoll.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin@lichtvoll.de
Cc: linux-kernel@vger.kernel.org, hancockrwd@gmail.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Martin Steigerwald <Martin@lichtvoll.de>
Date: Fri, 30 Oct 2009 09:15:51 +0100

> You don't need to when you used UUID or LABEL - I prefer the later cause 
> its more readable. Actually I never quite understood while one would want 
> to use dynamic things like /dev/hdd or /dev/sdb in the first place. Thats 
> for me not that much better than C: or D:. Connect your harddisks 
> differently and you are screwed.

Turns out I actually have UUID mounts, great!

Only hardcoded thing in my fstab is /dev/hdc for the cdrom.
