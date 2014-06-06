From: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/9] Serial ATA support for NVIDIA Tegra124
Date: Fri, 6 Jun 2014 10:18:19 +0300
Message-ID: <53916B3B.5030400@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com> <5390A8F9.2090408@wwwdotorg.org> <53915F3B.6050806@nvidia.com> <20140606071148.GC31915@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140606071148.GC31915@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Yes, that might be the easiest. If you go that way, you should probably 
also add an #include for the XUSB binding include file.

- Mikko

On 06/06/14 10:11, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Fri, Jun 06, 2014 at 09:27:07AM +0300, Mikko Perttunen wrote:
>> The only compile-time dependencies here should be that:
>> - patch 8 of 9 which contains the actual driver depends on patch 6 of 9
>> (though only when building as a module) and the efuse series
>> - patch 2 of 9 refers to the DT node called "padctl", so it requires the
>> xusb series. (in the submitted xusb series, the node isn't actually named,
>> though. I will fix this in v2)
>
> My intention was to add the label in the patch which first adds a
> reference to the device. In my tree that was the PCIe driver. Given that
> it's not clear yet in what order these will be merged, I'm thinking I
> should simply add that fragment in the patch that adds the node since we
> know that it will eventually be used.
>
> Thierry
>
> * Unknown Key
> * 0x7F3EB3A1
>
