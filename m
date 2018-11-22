From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
Date: Thu, 22 Nov 2018 11:36:51 +0300
Message-ID: <dabed310-3b2a-49b9-9297-625bf34a7f48@cogentembedded.com>
References: <20181121130439.22255-1-tiny.windzz@gmail.com>
 <e45f832b-ef98-e419-6082-27dd7ced71d2@cogentembedded.com>
 <CAEExFWvw1tw-AWbp1beajZNCRLYQXdiC6ifMvGc5_po64i_GtQ@mail.gmail.com>
 <CAEExFWsLP0oJVDV1KBENwsFKZ52ygZ18DQp1g1ah4a1ZmxeJLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEExFWsLP0oJVDV1KBENwsFKZ52ygZ18DQp1g1ah4a1ZmxeJLw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Lee <tiny.windzz@gmail.com>
Cc: b.zolnierkie@samsung.com, axboe@kernel.dk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 21.11.2018 18:33, Frank Lee wrote:

>>>> of_find_node_by_path() acquires a reference to the node
>>>> returned by it and that reference needs to be dropped by its caller.
>>>> bl_idle_init() doesn't do that, so fix it.
>>>
>>>     I thought we're inside pata_macio_cable_detect()?
> Hi Sergei：
> 
> Yeah,this is a typo.
> Need me to resend a patch?

    This is more of a question for the libata maintainers (but I would resend).

> Thanks，
> Yangtao

MBR, Sergei
