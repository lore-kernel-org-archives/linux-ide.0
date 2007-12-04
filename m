From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] sata_promise: make pdc_atapi_pkt() use values
 from qc->tf
Date: Tue, 04 Dec 2007 14:26:29 -0500
Message-ID: <4755A9E5.5070703@garzik.org>
References: <4754D89A.4070302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58721 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbXLDT0c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 14:26:32 -0500
In-Reply-To: <4754D89A.4070302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mikpe@it.uu.se, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Make pdc_atapi_pkt() use values from qc->tf instead of creating its
> own.  This is to ease future ATAPI handling changes.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mikael Pettersson <mikpe@it.uu.se>
> ---
> Okay, Mikael says it's good for trying out.  Please add this one to
> libata-dev#upstream.  Thanks.

applied


