From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream] libata: export local port number through /sys
Date: Mon, 25 Feb 2013 16:16:43 -0500
Message-ID: <512BD4BB.7000206@pobox.com>
References: <1359049929-17069-1-git-send-email-dmilburn@redhat.com> <512BD1DA.80305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:54757 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759604Ab3BYVQq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Feb 2013 16:16:46 -0500
Received: by mail-qa0-f42.google.com with SMTP id cr7so1886588qab.8
        for <linux-ide@vger.kernel.org>; Mon, 25 Feb 2013 13:16:45 -0800 (PST)
In-Reply-To: <512BD1DA.80305@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, kay.sievers@vrfy.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

On 02/25/2013 04:04 PM, David Milburn wrote:
> Hi Jeff, Gwendal, Kay,
>
> Any thoughts on this patch, is this something we could consider for
> 3.9?

As I noted in the upstream push email (and associated git tag text), it 
did not seem like all parties were happy with the sysfs layout.

	Jeff



