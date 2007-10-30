From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: [PATCH 2.6.24-rc1] sata_promise: ASIC PRD table bug workaround
Date: Tue, 30 Oct 2007 12:22:16 +0300
Message-ID: <4726F7C8.3010901@lxnt.info>
References: <200710300907.l9U97eW8024996@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:65453 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756662AbXJ3JWH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 05:22:07 -0400
In-Reply-To: <200710300907.l9U97eW8024996@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> 
> Unfortunately the name pdc_qc_prep() is already taken
> [it switches on qc->tf.protocol], so that leaves either pdc_fill_sg()
> [slightly imprecise as you noted], or uglies like __pdc_qc_prep(),
> pdc_qc_prep2(), or pdc_qc_prep_and_fill_sg() as names for the new
> procedure. I welcome suggestions for a better name.
> 

pdc_qc_prep_backend() ?


ps:
I almost stuck on naming the function while writing the patch,
put there first that came to mind just to not delay testing.

-- 

./lxnt
