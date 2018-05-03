From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] libata: blacklist Micron SSD
Date: Wed, 02 May 2018 23:14:24 -0400
Message-ID: <yq1muxh4ei7.fsf@oracle.com>
References: <20180429160138.11091-1-sudip.mukherjee@codethink.co.uk>
        <yq1r2mw83cu.fsf@oracle.com> <20180502215950.GA4621@sudip-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180502215950.GA4621@sudip-laptop> (Sudip Mukherjee's message
        of "Wed, 2 May 2018 22:59:50 +0100")
Sender: stable-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Sudip,

>> I think my preference would be to blacklist M500IT with the MU01
>> firmware (which Micron said was affected) and rely on the "Micron*"
>> fallthrough further down for the rest.
>
> This patch was based on your reply at:
> https://www.spinics.net/lists/linux-ide/msg55370.html

Yep, but they have confirmed it's only that model and firmware rev
that's affected. I just haven't gotten the comprehensive matrix of all
current models and firmware revs I was hoping for.

-- 
Martin K. Petersen	Oracle Linux Engineering
