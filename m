From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] ARM: S3C64XX: Add support for Compact Flash driver
	on SMDK6410
Date: Thu, 27 May 2010 20:45:59 +0100
Message-ID: <20100527194559.GC25921@n2100.arm.linux.org.uk>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com> <1274948524-2970-2-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33057 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757913Ab0E0TqK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 May 2010 15:46:10 -0400
Content-Disposition: inline
In-Reply-To: <1274948524-2970-2-git-send-email-kgene.kim@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Abhilash Kesavan <a.kesavan@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, ben-linux@fluff.org

On Thu, May 27, 2010 at 05:22:01PM +0900, Kukjin Kim wrote:
> +#include <mach/map.h>
> +#include <mach/gpio.h>

shouldn't this be linux/gpio.h ?
