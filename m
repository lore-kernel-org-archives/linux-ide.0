From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ata: increase retry count but shorten duration for
 Calxeda controller
Date: Mon, 6 May 2013 10:45:45 -0500
Message-ID: <CAOZdJXWBQGjs_eLJ_jdrcp5DYaPgFr50_ZF-eCHzPPMvHYgD-Q@mail.gmail.com>
References: <1367444087-18336-1-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367444087-18336-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

On Wed, May 1, 2013 at 4:34 PM, Mark Langsdorf
<mark.langsdorf@calxeda.com> wrote:
>
> -       const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
> +       unsigned long timing[] = { 5, 100, 500};


Why are you dropping the 'const'?

Assuming it works, this should be more efficient:

static const unsigned long timing[] = {5, 100, 500};
