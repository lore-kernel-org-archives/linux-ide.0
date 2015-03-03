From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] ide_tape: convert jiffies with jiffies_to_msecs
Date: Tue, 03 Mar 2015 17:22:40 +0300
Message-ID: <54F5C3B0.7080209@cogentembedded.com>
References: <1425379971-12641-1-git-send-email-hofrat@osadl.org> <54F5C101.9070409@cogentembedded.com> <20150303141509.GA30541@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150303141509.GA30541@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, "David S. Miller" <davem@davemloft.net>, Joe Perches <joe@perches.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 3/3/2015 5:15 PM, Nicholas Mc Guire wrote:

>>> Use jiffies_to_msecs for converting jiffies as it handles all of the corner
>>> cases reliably and also helps readability. The printk format is fixed up
>>> as jiffies_to_msecs returns unsigned int not unsigned long.

>>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>>> ---

>>> v2: change printk format string from %d to %u as suggested by
>>>       Joe Perches <joe@perches.com>.

>>> Note that this patch will give a checkpatch warning due to "quoted string
>>> split across lines" but thats not related to this change.

>>> This was only compile tested with x86_64_defconfig + CONFIG_IDE=m,
>>> CONFIG_BLK_DEV_IDETAPE=m

>>> Patch is against 4.0-rc1 (localversion-next is -next-20150303)

>>>    drivers/ide/ide-tape.c |    4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)

>>     The driver is called ide-tape.c, yet your subject prefix is "ide_tape:".

> that is based on the output of git log --oneline and it seems that it is
> the common prefix - in fact it seem rare to use the c-file name as prefix
> for patch subjects.

    Huh, what else is to be used for the prefix if not the file name?
    I would really like the prefix to be changed to "ide-tape", however it's 
up for DaveM, of course.

> thx!
> ofrat

WBR, Sergei
