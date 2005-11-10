From: Edward Falk <efalk@google.com>
Subject: Re: sata_sil24 corruption details
Date: Thu, 10 Nov 2005 12:27:32 -0800
Message-ID: <4373AD34.7080107@google.com>
References: <20051110071736.23747.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.12]:64078 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751227AbVKJU1r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 15:27:47 -0500
In-Reply-To: <20051110071736.23747.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com
Cc: linux-ide@vger.kernel.org


> Is there anything else I could do to help debug this problem?  Any additional
> debugging I can enable?

Check /var/log/kern.log for timeout messages; it would be interesting to 
see if you find any.

	-ed falk
