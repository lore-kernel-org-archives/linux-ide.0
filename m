From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 11/12] libata: use IRQ expecting
Date: Fri, 25 Jun 2010 23:52:02 -0400
Message-ID: <4C257962.1060506@garzik.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-12-git-send-email-tj@kernel.org> <4C23F6C1.7070603@garzik.org> <4C245E50.7090701@kernel.org> <4C2577F2.4030005@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C2577F2.4030005@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org
List-Id: linux-ide@vger.kernel.org

On 06/25/2010 11:45 PM, Jeff Garzik wrote:
> ata_qc_complete_multiple(), you call
> unexpect_irq()
> expect_irq()


Correction,

	unexpect_irq() x N
	expect_irq()

for N NCQ commands.

Controller-wide irq twiddling in the function that completes a single 
ATA command is painful.

	Jeff
