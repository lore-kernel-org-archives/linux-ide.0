From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) +
 PTR_ERR. Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR.
Date: Thu, 22 Sep 2016 13:44:36 +0300
Message-ID: <58067102-6e4d-dd09-50c6-8aa8b544def0@cogentembedded.com>
References: <1474487311-3897-1-git-send-email-harman4linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36822 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933703AbcIVKok (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2016 06:44:40 -0400
Received: by mail-lf0-f49.google.com with SMTP id g62so63440815lfe.3
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2016 03:44:39 -0700 (PDT)
In-Reply-To: <1474487311-3897-1-git-send-email-harman4linux@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harman Kalra <harman4linux@gmail.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 9/21/2016 10:48 PM, Harman Kalra wrote:

    Looks like your patch summary and description got merged together in the 
subject.

> Signed-off-by: Harman Kalra <harman4linux@gmail.com>
[...]

MBR, Sergei

