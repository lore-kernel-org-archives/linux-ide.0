From: Tejun Heo <tj@kernel.org>
Subject: Re: Potential race condition in drivers/ata/sata_mv.ko
Date: Thu, 11 Aug 2016 12:26:50 -0400
Message-ID: <20160811162650.GB2695@mtj.duckdns.org>
References: <8d7d8958-1a77-7c39-d008-fb6362e15d57@ispras.ru>
 <20160810035133.GD25053@mtj.duckdns.org>
 <904de563-24df-768a-9642-5aab5ed18f5e@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <904de563-24df-768a-9642-5aab5ed18f5e@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Andrianov <andrianov@ispras.ru>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Vaishali Thakkar <vaishali.thakkar@oracle.com>
List-Id: linux-ide@vger.kernel.org

On Thu, Aug 11, 2016 at 05:18:31PM +0300, Pavel Andrianov wrote:
> Hi!
> 
> I have found such example:
> 
> ... ->
> 
> ata_exec_internal_sg ->
> 
>     ata_qc_issue ->
> 
>         mv_qc_issue ->
> 
>             mv_clear_and_enable_port_irqs ->
> 
>                 mv_enable_port_irqs ->
> 
>                     mv_set_main_irq_mask
> 
> 
> ata_exec_internal_sg acquires spin_lock(ap->lock) and call of the last
> function mv_set_main_irq_mask is with this lock. mv_interrupt acquires
> spin_lock(host->lock) before call of the same function. I am not sure is it
> correct to add one more spin_lock or move a call of request_irq in
> ata_host_activate, thus I can not easily fix the issue.

ap->lock and host->lock point to the the same lock.  The only reason
ap->lock is a pointer is for SAS.

Thanks.

-- 
tejun
