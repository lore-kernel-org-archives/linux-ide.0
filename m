From: Youquan Song <youquan.song@linux.intel.com>
Subject: Re: [PATCH] ata: Fix DVD not dectected at some Haswell platforms
Date: Fri, 1 Feb 2013 10:26:12 -0500
Message-ID: <20130201152612.GA2186@linux-youquan.bj.intel.com>
References: <1359566374-27286-1-git-send-email-youquan.song@intel.com> <51091159.5080304@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51091159.5080304@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Youquan Song <youquan.song@intel.com>, htejun@gmail.com, ming.lei@canonical.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, seth.heasley@intel.com, jlee@suse.com, james.d.ralston@intel.com, Youquan Song <youquan.song@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

> On 30-01-2013 21:19, Youquan Song wrote:
>
>> There is a quirk patch 5e5a4f5d5a08c9c504fe956391ac3dae2c66556d
>
>   Please also specify the summary of that patch in parens.
>
>> fix the 4 ports
>
>    s/fix/fixing/
>
>> IDE controller 32bit PIO mode.
>> Recently, the problem was showed
>
>    s/showed/shown/
>
>> at Haswell platform which includes 2 ports IDE controller.
>
>> So introduce a qurik
>
>    Quirk.
>
>> patch to disable 32bit PIO at this IDE controller.
>
>    s/at/on/
>
>> Signed-off-by: Youquan Song <youquan.song@intel.com>
>
> MBR, Sergei

Thanks a lot! I have sent out a fixing patch for it.

-Youquan
