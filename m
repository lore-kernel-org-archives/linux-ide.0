From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-dev: irq-pio minor fix
Date: Tue, 04 Apr 2006 08:42:44 -0400
Message-ID: <443269C4.70100@pobox.com>
References: <11439680863256-git-send-email-htejun@gmail.com> <442FE142.7030304@pobox.com> <4430EE3C.9050608@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29900 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751045AbWDDMmw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Apr 2006 08:42:52 -0400
In-Reply-To: <4430EE3C.9050608@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Albert Lee wrote:
> irq-pio minor fix:
> - remove the redundant hsm_task_state = HSM_ST_IDLE
> - add devno to printk() as done in upstream 
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

applied both minor-fix patches


