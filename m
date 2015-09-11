From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ata: pata_pxa: dmaengine conversion
Date: Sat, 12 Sep 2015 00:24:57 +0200
Message-ID: <87h9n0twzq.fsf@belgarion.home>
References: <1441912069-620-1-git-send-email-robert.jarzmik@free.fr>
	<20150910210346.GM8114@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150910210346.GM8114@mtj.duckdns.org> (Tejun Heo's message of
	"Thu, 10 Sep 2015 17:03:46 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
List-Id: linux-ide@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> On Thu, Sep 10, 2015 at 09:07:49PM +0200, Robert Jarzmik wrote:
>> The PXA architecture was offered a slave dmaengine support. As a
>> consequence the direct DMA registers are progressively replaced by
>> dmaengine support.
>> 
>> This makes the pata_pxa change, which brings this driver to almost a
>> generic ATA 40-wires driver relying on dmaengine for transfers.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Applied to libata/for-4.4.
Thanks Tejun.

Cheers.

-- 
Robert
