From: Ric Wheeler <ric@emc.com>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 22:13:23 -0400
Message-ID: <446A86C3.4090904@emc.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com>	 <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com>	 <446A1A21.80501@emc.com> <446A4721.3030506@emc.com>	 <446A4BF5.7080006@garzik.org> <311601c90605161611s28538eebu61f887609f6b32f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:33211 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S932399AbWEQBN3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 21:13:29 -0400
In-Reply-To: <311601c90605161611s28538eebu61f887609f6b32f4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>


Eric D. Mudama wrote:

> On 5/16/06, Jeff Garzik <jeff@garzik.org> wrote:
>
>> Ric Wheeler wrote:
>> > But when I test with my synchronous write load, I am going at 6 times
>> > the normal rate (i.e., the rate I see with barriers disabled) ;-)
>>
>> Well, NCQ read/write commands have a 'FUA' bit...  though maybe the NCQ
>> code forgot to check the global libata_fua.
>>
>>         Jeff
>
>
> Is the workload a sequential write?  SATA drives should be able to
> keep up with the media if they use FUA for their consistency when
> using NCQ.
>
> Flush cache as a barrier mechanism will blow revs in sequential
> workloads, especially using a write/flush write/flush technique.


That would be a huge win for us, but this instance I mounted with 
barrier=flush (and that is the logged message in messages).  I suspect 
that our boot with write cache disabled + flip of the write cache to on 
during boot is the culprit...

Once we get past the basic working/not working barriers, I will retest 
the FUA vs flush barriers and post some results ;-)

ric

