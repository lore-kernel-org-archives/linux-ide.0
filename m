From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] libata: Add NOLPM quirk for SAMSUNG MZ7TE512HMHP-000L1
 SSD
Date: Wed, 6 Feb 2019 12:47:22 -0700
Message-ID: <0d9c6218-0b76-6135-1aaf-a97cdb7a1a51@kernel.dk>
References: <20190203090207.10930-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190203090207.10930-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 2/3/19 2:02 AM, Hans de Goede wrote:
> We've received a bugreport that using LPM with a SAMSUNG
> MZ7TE512HMHP-000L1 SSD leads to system instability, we already have
> a quirk for the MZ7TD256HAFV-000L9, which is also a Samsun EVO 840 /
> PM851 OEM model, so it seems some of these models have a LPM issue.
> 
> This commits adds a NOLPM quirk for the model string from the new
> bugeport, to avoid the reported stability issues.

Applied, thanks.

-- 
Jens Axboe
