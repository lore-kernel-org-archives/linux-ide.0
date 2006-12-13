From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] ata_piix: use piix_host_stop() in ich_pata_ops
Date: Wed, 13 Dec 2006 10:41:15 +0000
Message-ID: <b0943d9e0612130241k3363a2c9kd464d33122e6147f@mail.gmail.com>
References: <b0943d9e0612091454j6df1fb0ej2fa006c3fa33abae@mail.gmail.com>
	 <20061211132625.GA18947@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:3442 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbWLMKlQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Dec 2006 05:41:16 -0500
Received: by nz-out-0506.google.com with SMTP id s1so55377nze
        for <linux-ide@vger.kernel.org>; Wed, 13 Dec 2006 02:41:15 -0800 (PST)
In-Reply-To: <20061211132625.GA18947@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Tejun,

On 11/12/06, Tejun Heo <htejun@gmail.com> wrote:
> piix_init_one() allocates host private data which should be freed by
> piix_host_stop().  ich_pata_ops wasn't converted to piix_host_stop()
> while merging, leaking 4 bytes on driver detach.  Fix it.

I tried your patch last night but the leak is still reported. I need
to investigate further and put some printk's in the piix_host_stop
function to check whether the freeing really takes place.

What I can't follow is where the ata_port_info.private_data
(port_info[] or ppinfo[]) in piix_init_one gets transfered to
ata_host.private_data (the "host" argument) that piix_host_stop tries
to free.

-- 
Catalin
