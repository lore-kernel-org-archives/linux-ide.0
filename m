From: Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: Re: [PATCH 04/10] drivers: hwmon: use module_platform_driver_probe()
Date: Thu, 14 Mar 2013 17:42:34 +0100
Message-ID: <CAHkwnC8nn1SFv-wzf18jATGM+gfmR+sf+nrjATMNYkyWgR9bNw@mail.gmail.com>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <1363266691-15757-6-git-send-email-fabio.porcedda@gmail.com> <20130314140130.GB16825@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20130314140130.GB16825@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media <linux-media@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-input <linux-input@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean Delvare <khali@linux-fr.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Mar 14, 2013 at 3:01 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Mar 14, 2013 at 02:11:25PM +0100, Fabio Porcedda wrote:
>> This patch converts the drivers to use the
>> module_platform_driver_probe() macro which makes the code smaller and
>> a bit simpler.
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jean Delvare <khali@linux-fr.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: lm-sensors@lm-sensors.org
>> ---
>>  drivers/hwmon/mc13783-adc.c | 13 +------------
>>  1 file changed, 1 insertion(+), 12 deletions(-)
>>
> I have that one already queued for -next, submitted by Jingoo Han.

Ok i will drop this patch.

Best regards
Fabio Porcedda

> Thanks,
> Guenter
