From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 07/14] ide-cd: clear sense buffer before issuing	request
 sense
Date: Thu, 26 Mar 2009 16:26:24 +0900
Message-ID: <49CB2E20.5030202@kernel.org>
References: <1237910776-10983-1-git-send-email-tj@kernel.org> <1237910776-10983-8-git-send-email-tj@kernel.org> <20090326072044.GA32155@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753867AbZCZH0P@vger.kernel.org>
In-Reply-To: <20090326072044.GA32155@liondog.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: petkovbb@gmail.com, Tejun Heo <tj@kernel.org>, bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

Borislav Petkov wrote:
> Hmm, not quite. If its info->sense_data, then 18 is not correct. Rather,
> sizeof(struct request_sense) would be more likely the proper length. So,
> actually, it would be more like:
> 
> unsigned sense_len = 18;
> 
> if (sense == NULL) {
> 	sense = &info->sense_data;
> 	sense_len = sizeof(struct request_sense);
> }
> 
> memset(sense, 0, sense_len);

Okay, will update as such.  Thanks.

-- 
tejun
