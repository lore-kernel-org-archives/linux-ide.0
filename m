From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
Date: Mon, 13 Dec 2004 06:09:26 -0500
Message-ID: <41BD7866.4010009@pobox.com>
References: <16824.8109.697757.673632@devnull.wylie.me.uk>	<41BB41DC.6020808@pobox.com> <16829.29661.747368.799519@devnull.wylie.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40424 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262216AbULMLJf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Dec 2004 06:09:35 -0500
In-Reply-To: <16829.29661.747368.799519@devnull.wylie.me.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Alan J. Wylie" <alan@wylie.me.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, EC <wingman@waika9.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>

Is it possible for you to enable the following two #ifdefs in 
include/linux/libata.h, and send me the output?

/*
  * compile-time options
  */
#undef ATA_DEBUG                /* debugging output */
#undef ATA_VERBOSE_DEBUG        /* yet more debugging output */


