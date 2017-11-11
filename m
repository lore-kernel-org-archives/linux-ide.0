From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ahci: imx: Handle increased read failures for IMX53
 temperature sensor in low frequency mode.
Date: Sat, 11 Nov 2017 13:08:53 +0300
Message-ID: <0e1b7157-0738-7aac-98f8-75934c749c8a@cogentembedded.com>
References: <1510347098-20472-1-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45070 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdKKKIy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 11 Nov 2017 05:08:54 -0500
Received: by mail-lf0-f65.google.com with SMTP id n69so13581587lfn.2
        for <linux-ide@vger.kernel.org>; Sat, 11 Nov 2017 02:08:53 -0800 (PST)
In-Reply-To: <1510347098-20472-1-git-send-email-martyn.welch@collabora.co.uk>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martyn Welch <martyn.welch@collabora.co.uk>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Egor Starkov <egor.starkov@ge.com>

Hello!

On 11/10/2017 11:51 PM, Martyn Welch wrote:

> From: Egor Starkov <egor.starkov@ge.com>
> 
> Extended testing has shown that the imx ahci driver sometimes requires
> more than the 100 attempts currently alotted in the driver to perform a
> successful temperature reading when running at minimum (throttled) CPU
> frequency.
> 
> Debugging suggests that the read cycle canitake 160 attempts (which given

    Can take?

> that the driver averages 80 readings from the ADC equates to one failure
> on each read).
> 
> Increase the attempt limit to 200 in order to greatly reduce the
> likelyhood of the driver failing to perform a temperature reading,

    Likelihood.

> especially at low CPU frequency.
> 
> Signed-off-by: Egor Starkov <egor.starkov@ge.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
[...]

MBR, Sergei
