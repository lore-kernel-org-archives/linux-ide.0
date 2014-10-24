From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v2] ata: sata_rcar: Disable DIPM mode for r8a7790 ES1
Date: Fri, 24 Oct 2014 16:42:39 +0900
Message-ID: <CANqRtoTOehh=9kTmVnLBDCR4czO5ehRhaR10Um0vx0DA=wi5Bw@mail.gmail.com>
References: <1414116319-16813-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:43831 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbaJXHmk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Oct 2014 03:42:40 -0400
In-Reply-To: <1414116319-16813-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-ide@vger.kernel.org, Yoshihiro Kaneko <ykaneko0929@gmail.com>, SH-Linux <linux-sh@vger.kernel.org>

On Fri, Oct 24, 2014 at 11:05 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Unlike other SATA R-Car r8a7790 controllers the r8a7790 ES1 SATA R-Car
> controller needs to be run with DIPM disabled.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> v2
> * Handle ES1 in sata_rcar_init_controller()

This version looks fine to me. Thanks!

/ magnus
