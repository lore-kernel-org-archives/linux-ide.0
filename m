From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ahci: imx: Handle increased read failures for IMX53
 temperature sensor in low frequency mode.
Date: Mon, 13 Nov 2017 12:18:02 -0800
Message-ID: <20171113201802.GO983427@devbig577.frc2.facebook.com>
References: <1510569061-28993-1-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:48227 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755502AbdKMUSF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Nov 2017 15:18:05 -0500
Content-Disposition: inline
In-Reply-To: <1510569061-28993-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Egor Starkov <egor.starkov@ge.com>

On Mon, Nov 13, 2017 at 10:31:01AM +0000, Martyn Welch wrote:
> From: Egor Starkov <egor.starkov@ge.com>
> 
> Extended testing has shown that the imx ahci driver sometimes requires
> more than the 100 attempts currently alotted in the driver to perform a
> successful temperature reading when running at minimum (throttled) CPU
> frequency.
> 
> Debugging suggests that the read cycle can take 160 attempts (which given
> that the driver averages 80 readings from the ADC equates to one failure
> on each read).
> 
> Increase the attempt limit to 200 in order to greatly reduce the
> likelihood of the driver failing to perform a temperature reading,
> especially at low CPU frequency.
> 
> Signed-off-by: Egor Starkov <egor.starkov@ge.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>

Applied to libata/for-4.15.

Thanks.

-- 
tejun
