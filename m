From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] pata_arasan_cf: fix ata_host_activate() failure handling
Date: Mon, 14 Apr 2014 21:43:47 +0530
Message-ID: <CAOh2x=nQWZbYdbKpkVaXhRjTKq++GMujO+aFEBgLLyrEtsCPew@mail.gmail.com>
References: <1706948.xQXQIMFS2B@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:41717 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbaDNQNs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 12:13:48 -0400
In-Reply-To: <1706948.xQXQIMFS2B@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, Shiraz Hashim <shiraz.hashim@st.com>, "...)" <linux-ide@vger.kernel.org>, spear-devel <spear-devel@list.st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 14, 2014 at 9:31 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Add missing cf_exit() and clk_put() calls to ata_host_activate()
> failure path.
>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2:
> - re-order code and then drop redundant goto statement
>
>  drivers/ata/pata_arasan_cf.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
