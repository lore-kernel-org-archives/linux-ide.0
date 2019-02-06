From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] libata: Add NOLPM quirk for SAMSUNG MZ7TE512HMHP-000L1
 SSD
Date: Wed, 6 Feb 2019 20:00:04 +0100
Message-ID: <7fffe93a-a090-8cce-be49-f29e47942c6b@redhat.com>
References: <20190203090207.10930-1-hdegoede@redhat.com>
 <20190205185201.B3870217F9@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190205185201.B3870217F9@mail.kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 05-02-19 19:52, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v4.20.6, v4.19.19, v4.14.97, v4.9.154, v4.4.172, v3.18.133.
> 
> v4.20.6: Build OK!
> v4.19.19: Build OK!
> v4.14.97: Failed to apply! Possible dependencies:
>      410b5c7b4836 ("libata: blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD")
>      76936e9a6df1 ("libata: Apply NOLPM quirk for SAMSUNG PM830 CXM13D1Q.")
>      a435ab4f80f9 ("libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9")
>      b5b4d3a52c8f ("libata: Apply NOLPM quirk for SAMSUNG MZMPC128HBFU-000MV SSD")

The code to enable LPM support by default on mobile chipsets was merged
in the 4.16 kernel, so 4.14 (and older) don't need these blacklist patches
since they don't enable LPM by default (the user needs to write to a sysfs
attribute to enable it).

So it is fine to leave this patch out of 4.14.z and older.

Regards,

Hans


> 
> v4.9.154: Failed to apply! Possible dependencies:
>      410b5c7b4836 ("libata: blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD")
>      76936e9a6df1 ("libata: Apply NOLPM quirk for SAMSUNG PM830 CXM13D1Q.")
>      a435ab4f80f9 ("libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9")
>      b5b4d3a52c8f ("libata: Apply NOLPM quirk for SAMSUNG MZMPC128HBFU-000MV SSD")
> 
> v4.4.172: Failed to apply! Possible dependencies:
>      410b5c7b4836 ("libata: blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD")
>      76936e9a6df1 ("libata: Apply NOLPM quirk for SAMSUNG PM830 CXM13D1Q.")
>      a435ab4f80f9 ("libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9")
>      b5b4d3a52c8f ("libata: Apply NOLPM quirk for SAMSUNG MZMPC128HBFU-000MV SSD")
> 
> v3.18.133: Failed to apply! Possible dependencies:
>      410b5c7b4836 ("libata: blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD")
>      76936e9a6df1 ("libata: Apply NOLPM quirk for SAMSUNG PM830 CXM13D1Q.")
>      a435ab4f80f9 ("libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9")
>      b5b4d3a52c8f ("libata: Apply NOLPM quirk for SAMSUNG MZMPC128HBFU-000MV SSD")
> 
> 
> How should we proceed with this patch?
> 
> --
> Thanks,
> Sasha
> 
