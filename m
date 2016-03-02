From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from
 device-tree
Date: Wed, 2 Mar 2016 12:51:44 +0100
Message-ID: <56D6D3D0.9030408@xilinx.com>
References: <1455974302-7082-1-git-send-email-anuragku@xilinx.com>
 <3012728.7zDNPtQ7kR@wuerfel> <56D6B217.2000701@xilinx.com>
 <1798710.nJonRpmlxx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1798710.nJonRpmlxx@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Anurag Kumar Vulisha <anuragku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Srikanth Vemula <svemula-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On 2.3.2016 12:42, Arnd Bergmann wrote:
> On Wednesday 02 March 2016 10:27:51 Michal Simek wrote:
>>
>> No problem with default value in driver. Something has to be setup.
>> Reset value based on reg spec I was checking is 0x20. Based on our
>> testing we saw some issues that's why 0x40 was setup as default value.
>> There is a need to be able to configure this value for example for
>> testing different values that's why I think module parameter should be
>> the right way to go.
> 
> I don't object to the module parameter, but I don't understand how important
> that kind of testing is to normal users. Who would set it, aside from
> the person writing that driver to come up with the correct default?
> 
>> If this should be DT parameters there should be different ceva IP which
>> allows different fifo size and different watermark level to be setup by
>> user.
>>
>> What do you think? Does it sound reasonable.
> 
> Having a property for the actual hardware fifo size once you get
> different implementations seems like the correct approach, but it's
> moot as long as all implementations are hardwired to 128 entries.

yep right now and we don't know what can happen in future. I just wanted
to point to example where this property can be specified or wired to
particular compatible string.

Anurag: Please make it as module parameter instead of DT parameter.

Thanks,
Michal

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
