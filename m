From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 10/62] ata: remove the second argument of k[un]map_atomic()
Date: Mon, 28 Nov 2011 14:01:34 +0400
Message-ID: <4ED35BFE.6080900@mvista.com>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com> <1322371662-26166-11-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33772 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab1K1KCc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Nov 2011 05:02:32 -0500
In-Reply-To: <1322371662-26166-11-git-send-email-amwang@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cong Wang <amwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello.

On 27-11-2011 9:26, Cong Wang wrote:

> Signed-off-by: Cong Wang<amwang@redhat.com>
> ---
>   drivers/ata/libata-sff.c |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)

    IMO, you should do this in a single patch, not piecemeal to keep the 
kernel bisectable.

WBR, Sergei
