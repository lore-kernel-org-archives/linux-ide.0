From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 0/3] libata: scsi error handling, encore
Date: Sat, 15 Oct 2005 12:54:07 +0900
Message-ID: <43507D5F.2050407@gmail.com>
References: <43490BC8.9060504@torque.net> <434919E4.1080601@pobox.com> <435069E3.90306@torque.net> <43506AA3.3030502@pobox.com> <43507BA7.6090406@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <43507BA7.6090406@torque.net>
Sender: linux-scsi-owner@vger.kernel.org
To: dougg@torque.net
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, russb@emc.com
List-Id: linux-ide@vger.kernel.org

Douglas Gilbert wrote:
> Jeff Garzik wrote:
> 
>>Douglas Gilbert wrote:
>>
>>
>>>Six days have passed and "git pull ..../libata-dev" still
>>>does not reflect these changes. Am I doing something
>>>wrong? Should I wait before submitting more changes?
>>
>>
>>Your changes are committed to the 'upstream' branch.  Maybe you need to do
>>    git pull $url upstream
> 
> 
> Jeff,
> Thanks, indeed I do. Obviously the fact the 'upstream'
> was the active branch in the destination directory was
> not sufficient. So do I need to do both
> 'git pull $url' and 'git pull $url upstream' or is
> the latter sufficient?
> 
> "git" does seems an appropriate name :-)
> 
> Doug Gilbert
> 

  Hi, Doug,

  I use the following script.

$ cat ~/bin/git-sync.sh
#!/bin/sh

if [ ! -r .git/origin ]; then
         echo "not in git repo" 2>&1
         exit 1
fi

rsync -avz --ignore-existing $(cat .git/origin)/ .git/
rsync -avz $(cat .git/origin)/refs/ .git/refs/

  After syncing, you need to do 'git-read-tree -m upstream' 
'git-checkout-cache -q -f -u -a'

-- 
tejun
