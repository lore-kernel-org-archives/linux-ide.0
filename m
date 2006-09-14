From: "Tuomas Leikola" <tuomas.leikola@gmail.com>
Subject: Re: libata hotplug with md, unplugging does not remove drive from md?
Date: Thu, 14 Sep 2006 19:01:48 +0300
Message-ID: <5b170a7d0609140901v6f2425bdy463823213d3927d5@mail.gmail.com>
References: <c384c5ea0609120656w478afacblcd51d2a346401d6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:2978 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750950AbWINQBu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Sep 2006 12:01:50 -0400
Received: by ug-out-1314.google.com with SMTP id o38so74692ugd
        for <linux-ide@vger.kernel.org>; Thu, 14 Sep 2006 09:01:49 -0700 (PDT)
In-Reply-To: <c384c5ea0609120656w478afacblcd51d2a346401d6d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Cc: linux-ide@vger.kernel.org

On 9/12/06, Leon Woestenberg <leon.woestenberg@gmail.com> wrote:
> When I unplug that drive, /dev/sda is removed, hotplug seems to work to
> the point where proc/mdstat shows the drive failed, but not removed.
>
> Replugging shows the drive re-appearing as /dev/sde
>
> It seems hot unplug does not remove a drive from an md array.
>
> Is this intentional?

Yes. You may want to re-add it to the array (see man mdadm (new-ish)
for --re-add with bitmaps). Your userspace should probably take care
of removing the failed device.
