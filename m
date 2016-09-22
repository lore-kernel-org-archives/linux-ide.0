From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) +
 PTR_ERR. Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR.
Date: Thu, 22 Sep 2016 16:53:04 +0300
Message-ID: <561a31e9-eaa5-9be5-989e-8898fdaecc34@cogentembedded.com>
References: <1474487311-3897-1-git-send-email-harman4linux@gmail.com>
 <58067102-6e4d-dd09-50c6-8aa8b544def0@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58067102-6e4d-dd09-50c6-8aa8b544def0@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harman Kalra <harman4linux@gmail.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 09/22/2016 01:44 PM, Sergei Shtylyov wrote:

>    Looks like your patch summary and description got merged together in the
> subject.

    Also, the subject (summary) should contain driver name as a prefix: 
"pata_at91: Use ..."

>> Signed-off-by: Harman Kalra <harman4linux@gmail.com>
> [...]

MBR, Sergei
