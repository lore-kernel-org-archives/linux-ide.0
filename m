From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
Date: Mon, 30 Jul 2018 17:26:45 +0200
Message-ID: <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
 <20180730152256.GF1206094@devbig004.ftw2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730152256.GF1206094@devbig004.ftw2.facebook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 30-07-18 17:22, Tejun Heo wrote:
> On Mon, Jul 30, 2018 at 08:15:47AM -0700, Srinivas Pandruvada wrote:
>> Hi Tejan,
>>
>> On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada wrote:
>>> Some minor fixes to be able to correctly set devslp register
>>> to optimize power.
>>>
>>> Srinivas Pandruvada (2):
>>>    ata: libahci: Correct setting of DEVSLP register
>>>    ata: libahci: Allow reconfigure of DEVSLP register
>>>
>> Are you applying this series?
> 
> I was waiting for Hans's reviews.  Hans, what do you think?

Ah I missed that this was another series. With the caveat that
I do not really know that much about devslp, both patches
seem sensible to me, so both are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
