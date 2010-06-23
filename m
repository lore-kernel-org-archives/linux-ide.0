From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v4] libata: pata_samsung_cf: Add Samsung PATA controller
 driver
Date: Wed, 23 Jun 2010 16:36:27 -0400
Message-ID: <4C22704B.50103@pobox.com>
References: <1276499263-12217-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46690 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab0FWUge (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jun 2010 16:36:34 -0400
In-Reply-To: <1276499263-12217-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, Abhilash Kesavan <a.kesavan@samsung.com>

On 06/14/2010 03:07 AM, Kukjin Kim wrote:
> From: Abhilash Kesavan<a.kesavan@samsung.com>
>
> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsystem.
>
> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>

Acked-by: Jeff Garzik <jgarzik@redhat.com>

Send it through the appropriate subsystem tree for this platform...


