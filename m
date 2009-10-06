From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH REDIFFED 2/4 #upstream] libata: implement more acpi filtering
 options
Date: Tue, 06 Oct 2009 00:56:00 -0400
Message-ID: <4ACACDE0.2020607@pobox.com>
References: <4A77F6B8.4000000@kernel.org> <4AA702E7.7030905@pobox.com> <4AAFE82E.8090306@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56696 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbZJFE5E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Oct 2009 00:57:04 -0400
In-Reply-To: <4AAFE82E.8090306@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: ide <linux-ide@vger.kernel.org>, meissner@novell.com

On 09/15/2009 03:17 PM, Tejun Heo wrote:
> Currently libata-acpi can only filter DIPM among SATA feature enables
> via _GTF.  This patch adds the capability to filter out FPDMA non-zero
> offset, in-order guarantee and auto-activation.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-acpi.c |   19 +++++++++++++++----
>   include/linux/ata.h       |    3 +++
>   include/linux/libata.h    |    2 ++
>   3 files changed, 20 insertions(+), 4 deletions(-)

applied this series


