From: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: [PATCH] IDE: typo in ide-io.c leads to faulty assignment
Date: Mon, 27 Nov 2006 17:01:16 +0100
Message-ID: <9a8748490611270801g38417047ybcf4304bad9ad673@mail.gmail.com>
References: <87k61h3pu2.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758344AbWK0QBS@vger.kernel.org>
In-Reply-To: <87k61h3pu2.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 27/11/06, Elias Oltmanns <eo@nebensachen.de> wrote:
> Due to a typo in ide_start_power_step, the result of a function rather
> than its pointer is assigned to args->handler. The patch applies to
> 2.6.19-rc6 but the problem exists in the stable branch as well.
>

These two lines :

-		args->handler = task_no_data_intr;
+		args->handler = &task_no_data_intr;

do the same thing.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
