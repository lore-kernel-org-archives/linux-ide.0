From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: add a host flag to ignore detected ATA devices
Date: Mon, 07 May 2012 15:43:57 -0400
Message-ID: <4FA825FD.4060103@pobox.com>
References: <4F903529.40800@mvista.com> <1336166111-20483-1-git-send-email-apw@canonical.com> <1336166111-20483-2-git-send-email-apw@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:48230 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab2EGToA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2012 15:44:00 -0400
In-Reply-To: <1336166111-20483-2-git-send-email-apw@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Whitcroft <apw@canonical.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 05/04/2012 05:15 PM, Andy Whitcroft wrote:
> Where devices are visible via more than one host we sometimes wish to
> indicate that cirtain devices should be ignored on a specific host.  Add a
> host flag indicating that this host wishes to ignore ATA specific devices.
>
> Signed-off-by: Andy Whitcroft<apw@canonical.com>

applied 1-2



