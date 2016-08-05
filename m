From: Pavel Andrianov <andrianov@ispras.ru>
Subject: Potential race condition in drivers/ata/sata_mv.ko
Date: Fri, 5 Aug 2016 15:43:30 +0300
Message-ID: <8d7d8958-1a77-7c39-d008-fb6362e15d57@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Vaishali Thakkar <vaishali.thakkar@oracle.com>
List-Id: linux-ide@vger.kernel.org

Hi!

In drivers/ata/sata_mv.ko function mv_set_main_irq_mask is called 
several times. Twice with a spinlock, twice from init function and once 
without any protection. The call without protection rises to several 
handlers from ata_port_operations. The structure with the 
ata_port_operations is included into a structure 'host' in 
mv_platform_probe and in mv_pci_init_one. At the end of these functions 
ata_host operations are activated together with interrupt handler. The 
conclusion is: interrupt handler may be executed in parallel with 
handlers from ata_port_operations, or, more formally, it may interrupt 
its execution.

In mv_set_main_irq_mask and in interrupt handler mv_interrupt the 
interrupt mask is modified, but, as I said, handlers from 
ata_port_operations do not acquire any lock. Thus, the interrupt mask 
may be set incorrectly if the are two conflicting modifications.


-- 
Pavel Andrianov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: andrianov@ispras.ru
