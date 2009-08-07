From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] When a disk needs to be waken up from sleep, ensure that
 the command is retried by SCSI EH.
Date: Sat, 08 Aug 2009 07:37:50 +0900
Message-ID: <4A7CACBE.6090208@kernel.org>
References: <e7510f760908071519m3bb8f120s485f8a0dd0d2259f@mail.gmail.com> <1249684013-24307-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46798 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbZHGWfd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Aug 2009 18:35:33 -0400
In-Reply-To: <1249684013-24307-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Gwendal Grignou wrote:
> ---
>  drivers/ata/libata-eh.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

The patch description is missing again but other than that

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
