From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] libata: allow sata_sil24 to opt-out of tag ordered
 submission
Date: Mon, 19 Jan 2015 17:24:30 +0300
Message-ID: <54BD139E.7080204@cogentembedded.com>
References: <20150116231225.18771.75061.stgit@viggo.jf.intel.com> <20150116231302.18771.62862.stgit@viggo.jf.intel.com> <54BA409E.4040901@cogentembedded.com> <20150119141249.GA8140@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150119141249.GA8140@htj.dyndns.org>
Sender: stable-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org, Ronny Hegewald <Ronny.Hegewald@online.de>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 1/19/2015 5:12 PM, Tejun Heo wrote:

>>>   	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
>>> -		tag = tag < max_queue ? tag : 0;
>>> +		if (ap->flags & ATA_FLAG_LOWTAG)
>>> +			tag = i;
>>> +		else
>>> +			tag = tag < max_queue ? tag : 0;

>>     Ugh, this is clear abuse of the ?: operator... Why not simply:

>> 		else if (tag >= max_queue)
>> 			tag = 0;

> Why is that a clear abuse?  Seems like a pretty typical use to me.

    This is my first reaction to statements like 'x = x < M ? x : 0'. I really
prefer two-liners with *if* to them.

> Thanks.

MBR, Sergei
