From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Debugging strange system lockups possibly triggered by ATA commands
Date: Wed, 11 Oct 2006 15:19:58 +0200
Message-ID: <41840b750610110619v56d3efd5h7a05cfb42cb21464@mail.gmail.com>
References: <741Eo-2m9-5@gated-at.bofh.it> <742hc-4n3-25@gated-at.bofh.it>
	 <87ejtgatgp.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:55444 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751272AbWJKNUA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Oct 2006 09:20:00 -0400
Received: by ug-out-1314.google.com with SMTP id o38so103272ugd
        for <linux-ide@vger.kernel.org>; Wed, 11 Oct 2006 06:19:58 -0700 (PDT)
In-Reply-To: <87ejtgatgp.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, hdaps-devel@sourceforge.net

Hi Elias,

On 10/10/06, Elias Oltmanns <oltmanns@uni-bonn.de> wrote:
> Testing the queue handling stuff without actually issuing any
> commands seems rather difficult to me as its the callback mechanism
> used to freeze the queue after command completion which I'd really
> like to test. If I don't issue any command, I don't know how to test
> whether the callback procedure and all the rest works as expected.

Try doing a dump_stack(), and nothing else, in the callback. This may
provide some hint.

(Remember to increase console_loglevel so you can see the result on
the console before the hang.)

  Shem
