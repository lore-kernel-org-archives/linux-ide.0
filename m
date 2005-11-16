From: Edward Falk <efalk@google.com>
Subject: Re: [PATCH 2/5] sil24: add sil24_restart_controller
Date: Wed, 16 Nov 2005 10:26:02 -0800
Message-ID: <437B79BA.2040200@google.com>
References: <20051116080244.GB22807@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.12]:7182 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030421AbVKPS0r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Nov 2005 13:26:47 -0500
In-Reply-To: <20051116080244.GB22807@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org



> +static int __sil24_restart_controller(void __iomem *port)

Hi; I'm curious:  why the leading underscores in the function name?

	-ed falk
