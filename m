From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] libata: change the last state of pio read to HSM_ST_IDLE
Date: Tue, 02 Oct 2007 11:19:07 -0400
Message-ID: <4702616B.1000402@garzik.org>
References: <468B5930.3070000@tw.ibm.com> <468B5B3D.6040805@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50713 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102AbXJBPTJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 11:19:09 -0400
In-Reply-To: <468B5B3D.6040805@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Patch 2/2:
>   After reading the last pio data block, the HSM is waiting for device
> to be idle, not waiting for the last interrupt.
> 
> This patch changes the state after "PIO data-in" to HSM_ST_IDLE instead
> of HSM_ST_LAST for accuracy.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Is this still needed?


