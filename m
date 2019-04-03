From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 8/9] drivers: ata: sata_gemini: use devm_platform_ioremap_resource()
Date: Wed, 3 Apr 2019 10:37:20 +0700
Message-ID: <CACRpkdYVCTzQJ+pXH6qzaB3mu9=-LVNhp04Wxxgd=R4r7hkePg@mail.gmail.com>
References: <1552382374-28789-1-git-send-email-info@metux.net> <1552382374-28789-8-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552382374-28789-8-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 12, 2019 at 4:19 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
