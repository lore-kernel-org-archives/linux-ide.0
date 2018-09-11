From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] pata_atiixp: Remove unnecessary parentheses
Date: Tue, 11 Sep 2018 16:57:21 -0600
Message-ID: <fee3ed2a-4aa6-e9d8-dbcd-8f1f8ee67d06@kernel.dk>
References: <20180911214338.1109-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911214338.1109-1-natechancellor@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-ide@vger.kernel.org

On 9/11/18 3:43 PM, Nathan Chancellor wrote:
> Clang warns when more than one set of parentheses is used for a
> single conditional statement:
> 
> drivers/ata/pata_atiixp.c:282:19: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>             ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/ata/pata_atiixp.c:282:19: note: remove extraneous parentheses
> around the comparison to silence this warning
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>            ~             ^                              ~
> drivers/ata/pata_atiixp.c:282:19: note: use '=' to turn this equality
> comparison into an assignment
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>                          ^~
>                          =
> 1 warning generated.

Applied for 4.20, thanks.

-- 
Jens Axboe
