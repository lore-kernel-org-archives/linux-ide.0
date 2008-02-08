From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH] libata: Cable strategy
Date: Fri, 08 Feb 2008 10:45:21 -0500
Message-ID: <47AC7911.10700@redhat.com>
References: <20080208152138.28d5dfdb@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48853 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbYBHPpp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Feb 2008 10:45:45 -0500
In-Reply-To: <20080208152138.28d5dfdb@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

On 02/08/2008 10:21 AM, Alan Cox wrote:
> +		ata_link_for_each_dev(dev, link) {
> +			if (!ata_is_40wire(dev))
> +				return 1;
> +		}

				return 0;  ???


